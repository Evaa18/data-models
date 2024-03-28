# My Job Glasses Doc for DBT

... is on [Notion](https://www.notion.so/Installer-et-mettre-jour-DBT-784dc9410557449b9078636be40b9fd6)

It covers setup, virtual env, updating dependencies, etc

# Metabase

See https://github.com/gouline/dbt-metabase

## Production

Copy the dbt-metabase.config.example.yml as indicated in the file, and add your credentials

```bash
dbt-metabase models
dbt-metabase exposures
```

## Local tests

See https://www.notion.so/myjobglasses/M-tabase-Guide-d-Utilisation-748ba98e94f34c7fa735834906f6ae0b#4208cfaee1fa46a1be1a4f338f9f38f2 to setup local metabase with docker

```
$METABASE_USER
$METABASE_PASSWORD

dbt-metabase models \
    --dbt_path . \
    --dbt_schema dbt_production \
    --dbt_database alexandria-stitch \
    --metabase_host localhost:3000 \
    --metabase_user $METABASE_USER \
    --metabase_password "$METABASE_PASSWORD" \
    --metabase_database 'DBT Production' \
    --metabase_http \
    --verbose \
    --dbt_manifest_path target/manifest.json \

dbt-metabase exposures \
    --dbt_path . \
    --dbt_schema public \
    --dbt_database dbt_production \
    --metabase_host localhost:3000 \
    --metabase_user $METABASE_USER \
    --metabase_password "$METABASE_PASSWORD" \
    --metabase_database 'DBT Production' \
    --metabase_http \
    --output_path ./models/metabase/ \
    --output_name metabase_exposures \
    --dbt_manifest_path target/manifest.json \
;
```

# Resources:

- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
