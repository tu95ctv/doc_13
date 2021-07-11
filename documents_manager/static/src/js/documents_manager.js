odoo.define('documents_manager.documents_manager', function(require) {
    "use strict";

    var AbstractAction = require('web.AbstractAction');
    window.odoo_Dialog = require('web.Dialog');
    window.core = require('web.core');

    var CustomPageWidget = AbstractAction.extend({
        template: 'documents_manager_template',
        init: function(parent, action) {
            this._super.apply(this, arguments);
            window.action_manager = parent;
        },
    });

    core.action_registry.add('documents_manager.documents_manager', CustomPageWidget);

    return CustomPageWidget;

})