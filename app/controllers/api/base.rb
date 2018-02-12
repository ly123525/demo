module API
  class Base < Grape::API
    mount V1::Users

    add_swagger_documentation(
        info: {
            title: 'GrapeRailsTemplate API Documentation',
            contact_email: '182160328@qq.com'
        },
        mount_path: '/doc/swagger',
        doc_version: '0.1.0'
    )

  end
end
