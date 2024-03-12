#!/bin/bash

set -x

# Initiate bench and getting Apps
bench init --frappe-path https://vignesh-rameshkumar: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@github.com/AgnikulCosmos/frappe-live --frappe-branch develop frappe-14
cd frappe-14
bench set-config -g developer_mode 1
bench get-app https://vignesh-rameshkumar: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@github.com/AgnikulCosmos/erpnextlive --branch develop --resolve-deps
bench get-app https://vignesh-rameshkumar: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@github.com/AgnikulCosmos/india_compliance --branch develop --resolve-deps
bench get-app https://vignesh-rameshkumar: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@github.com/AgnikulCosmos/hrms --branch develop --resolve-deps
bench get-app https://vignesh-rameshkumar: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@github.com/AgnikulCosmos/doppio --branch develop --resolve-deps
bench get-app https://vignesh-rameshkumar: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@github.com/AgnikulCosmos/frappe_types --branch develop --resolve-deps
#bench get-app https://vignesh-rameshkumar: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@github.com/AgnikulCosmos/fleet_management --branch main --resolve-deps
#bench get-app https://vignesh-rameshkumar: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@github.com/AgnikulCosmos/budgeting --branch main --resolve-deps
#bench get-app https://vignesh-rameshkumar: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@github.com/AgnikulCosmos/visitor_management --branch main --resolve-deps
#cd /home/vickypandiyan/frappe-14/apps/visitor_management/qr_code
#yarn add vite
#cd  /home/vickypandiyan/frappe-14/apps/visitor_management/Visitor
#yarn add vite
#cd /home/vickypandiyan/frappe-14/
#bench build --app visitor_management
#bench get-app payments --resolve-deps
#bench get-app https://vignesh-rameshkumar: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@github.com/AgnikulCosmos/fandb --branch main --resolve-deps
