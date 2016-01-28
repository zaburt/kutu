// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require console_fallback
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require foundation
//= require turbolinks


// turbolinks messes up with foundation triggers, especially the image selector modal
var foundation_ready_trigger;
foundation_ready_trigger = function() {
    $(document).foundation();
};
$(document).ready(foundation_ready_trigger);
$(document).on('page:load', foundation_ready_trigger);

