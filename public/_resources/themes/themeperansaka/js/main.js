(function ($) {
    "use strict";

    /**
     * Smooth Scroll
     * 
     * @author DKD Jatim
     * @since  1.0.0
     */
    $('a[href*="#"]')
        // Remove links that don't actually link to anything
        .not('[href="#"]')
        .not('[href="#0"]')
        .click(function (event) {
            // On-page links
            if (
                location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') &&
                location.hostname == this.hostname
            ) {
                // Figure out element to scroll to
                var target = $(this.hash);
                target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
                // Does a scroll target exist?
                if (target.length) {
                    // Only prevent default if animation is actually gonna happen
                    event.preventDefault();
                    $('html, body').animate({
                        scrollTop: target.offset().top
                    }, 1000, function () {
                        // Callback after animation
                        // Must change focus!
                        var $target = $(target);
                        $target.focus();
                        if ($target.is(":focus")) { // Checking if the target was focused
                            return false;
                        } else {
                            $target.attr('tabindex', '-1'); // Adding tabindex for elements not focusable
                            $target.focus(); // Set focus again
                        };
                    });
                }
            }
        });

    /**
     * Back to Top buttons
     * 
     * @author DKD Jatim
     * @since  1.0.0
     */
    var $backToTop = $(".btn-btt");
    $backToTop.hide();
    $(window).on('scroll', function () {
        if ($(this).scrollTop() > 100) {
            $backToTop.fadeIn();
            $('.navigation').addClass('fixed');
            $('#about').addClass('sticky');
        } else {
            $backToTop.fadeOut();
            $('#about').removeClass('sticky');
            $('.navigation').removeClass('fixed');
        }
    });

    $backToTop.on('click', function (e) {
        $("html, body").animate({
            scrollTop: 0
        }, 500);
    });

    /**
     * Navbars
     * 
     * @author DKD Jatim
     * @since  1.0.0
     */
    $(document).ready(() => {
        if ($(window).width() < 600) {
            $('.navigation .collapse').collapse('hide');

            // Navbar On Click
            $('.navigation .nav-link').click(() => {
                $('.navigation .collapse').collapse('hide');
            });
        } else {
            $('.navigation .collapse').collapse('show');
        }
    });
})(jQuery);