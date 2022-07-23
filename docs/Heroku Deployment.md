# Heroku Setup
Heroku setup is handled automatically by the pipeline defined in .github/workflows/cd.yml

The pipeline runs tests on your code and uses akhileshns/heroku-deploy@v3.12.12 to deploy.
You are required to modify:
1. heroku_api_key: set this secret within github
2. heroku_app_name: your heroku app name
3. heroku_email: your email for heroku login

The heroku.yml configuration contains deployment information for your site.