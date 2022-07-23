# Heroku Setup
Heroku setup is handled automatically by the pipeline defined in .github/workflows/cd.yml.
This pipeline runs on merge/push to a `staging` branch.

You should create an app in heroku for this project before you proceed.
Set the required env variables in heroku > settings > config vars. For this application
I will be setting:
1. DJANGO_SECRET_KEY=foo
2. DJANGO_DEBUG=true
3. DJANGO_SETTINGS_MODULE=config.settings.heroku

Add Heroku postgres as a resource. This will automatically add the DATABASE_URL variable.

The pipeline runs tests on your code and uses akhileshns/heroku-deploy@v3.12.12 to deploy.
You are required to modify:
1. heroku_api_key: set this secret within github
2. heroku_app_name: your heroku app name, you should create an app before this pipeline runs
3. heroku_email: your email for heroku login

The heroku.yml configuration contains deployment information for your site.