# syntax=docker/dockerfile:1

ARG RUBY_VERSION=4.0.6

########################################
# Base: common OS packages for build+run
########################################
FROM ruby:${RUBY_VERSION}-slim AS base

ENV LANG=C.UTF-8 \
    RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=development:test

# Runtime libraries needed by the app itself:
#  - libpq5: PostgreSQL client library (pg gem)
#  - imagemagick: Paperclip image processing
#  - shared-mime-info: MIME type database required by mimemagic (paperclip dependency)
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
      libpq5 \
      imagemagick \
      shared-mime-info \
      curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

########################################
# Build stage: compile gems and assets
########################################
FROM base AS build

# Build tools + headers needed only to compile native gem extensions
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
      build-essential \
      git \
      pkg-config \
      libpq-dev \
      nodejs \
    && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs "$(nproc)" && \
    rm -rf /usr/local/bundle/cache/*.gem && \
    find /usr/local/bundle/ruby/*/gems -name "*.c" -delete && \
    find /usr/local/bundle/ruby/*/gems -name "*.o" -delete

COPY . .

# Precompile assets. A dummy SECRET_KEY_BASE is enough since it's only
# needed to boot the app, not to actually serve requests.
RUN SECRET_KEY_BASE=dummy_for_asset_precompile \
    ./bin/rails assets:precompile

########################################
# Final runtime image
########################################
FROM base AS final

RUN groupadd --system --gid 1000 rails && \
    useradd --system --uid 1000 --gid rails --create-home rails

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build --chown=rails:rails /app /app

RUN mkdir -p log tmp public/system storage && \
    chown -R rails:rails /app

USER rails

EXPOSE 3000

ENTRYPOINT ["bin/docker-entrypoint"]

CMD ["bin/rails", "server", "-b", "0.0.0.0"]
