// ==UserScript==
// @name        Force BigBlueTerm437 Nerd Font
// @description Force my preferred font except on excluded domains
// @include     *
// @exclude     *://github.com/*
// @exclude     *://*.github.com/*
// @exclude     *://claude.ai/*
// @exclude     *://*.claude.ai/*
// @run-at      document-start
// ==/UserScript==

(function () {
    "use strict";

    const css = `
        *:not(i):not([class*="icon"]),
        *:not(i):not([class*="icon"])::before,
        *:not(i):not([class*="icon"])::after {
            font-family: "BigBlueTerm437 Nerd Font" !important;
        }
    `;

    const style = document.createElement("style");
    style.textContent = css;

    const inject = () => {
        if (document.documentElement && !style.isConnected) {
            document.documentElement.appendChild(style);
        }
    };

    inject();

    new MutationObserver(inject).observe(document, {
        childList: true,
        subtree: true
    });
})();
