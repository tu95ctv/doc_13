# -*- coding: utf-8 -*-
{
    'name': "Viindoo Document management",
    'name_vi_VN':'Quản lý tài liệu',
    'summary': "Document management",
    'summary_vi_VN':'Quản lý tài liệu',
    'description': """
        upload, download and manage your documents.
    """,
    'author': "Viindoo",
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
    'depends': ['base', 'mail', 'portal', 'web', 'attachment_indexation', 'digest','graphql_base'],
    'data': [
        'security/security.xml',
        'security/ir.model.access.csv',
        'data/documents_data.xml',
        'views/documents_views.xml',
        'views/documents_configs/documents_folder_views.xml',
        'views/documents_configs/res_config_settings_views.xml',
        'views/documents_configs/documents_share_views.xml',
        'views/documents_configs/documents_workflow_rule_views.xml',
        'views/documents_configs/documents_facet_views.xml',
        'views/documents_configs/documents_tag_views.xml',
        # 'views/documents_configs/res_partner.xml',
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

    'external_dependencies': {
        'bin': [
        ],
        'python': [
            'graphene',
        ],
    },

}
