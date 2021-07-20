# -*- coding: utf-8 -*-
{
    'name': "ViinDoo Documents",
    'name_vi_VN':'Quản lý tài liệu',
    'summary': "ViinDoo Document management",
    'summary_vi_VN':'Quản lý tài liệu',
    'description': """
        App to upload and manage your documents.
    """,
    'author': "ViinDoo",
    'category': 'Productivity/Documents',
    'sequence': 80,
    'version': '0.1.0',
    'installable':True,
    'application': True,
    'auto_install':False,
    'website': 'https://viindoo.com',
    'live_test_url':'',
    'support': 'apps.support@viindoo.com',
    'price': 99.9,
    'currency': 'EUR',
    'license': 'OPL-1',
    # any module necessary for this one to work correctly
    'depends': ['base', 'mail', 'portal', 'web', 'attachment_indexation', 'digest'],

    # always loaded
    'data': [
        'security/security.xml',
        'security/ir.model.access.csv',
        # 'data/digest_data.xml',
        'data/documents_data.xml',
        # 'data/workflow_data.xml',
        # 'data/files_data.xml',
        # 'data/mail_templates.xml',
        'views/vii_assets.xml',

        'views/documents_views.xml',
        'views/documents_configs/documents_folder_views.xml',
        'views/documents_configs/res_config_settings_views.xml',
        'views/documents_configs/documents_share_views.xml',
        'views/documents_configs/documents_workflow_rule_views.xml',
        'views/documents_configs/documents_facet_views.xml',
        'views/documents_configs/documents_tag_views.xml',

        # 'views/documents_configs/res_partner.xml',

        'views/vii_templates.xml',
        # 'views/activity_views.xml',
        # 'wizard/request_activity_views.xml',

        'views/menu.xml',
    ],

    'qweb': [
        # "static/src/xml/*.xml",
        # "static/src/owl/components/pdf_manager/pdf_manager.xml",
        # "static/src/owl/components/pdf_page/pdf_page.xml",
        # "static/src/owl/components/pdf_group_name/pdf_group_name.xml",
    ],

    'demo': [
        # 'demo/demo.xml',
    ],
    'license': 'OEEL-1',
}
