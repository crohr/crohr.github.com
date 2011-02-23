---
layout: post
title: Issue with Ruby1.9.2 YAML parser and merge keys in YAML configuration file
published: true
---

# Issue with Ruby1.9.2 YAML parser and merge keys in YAML configuration file
Just a quick tip in case someone encounters the same problem: given the following YAML configuration file in a Rails3 app using Ruby1.9.2, and the corresponding code to load the `production` section, what result would you expect for `h["production"]["pool"]`?

YAML configuration file:

    defaults: &defaults
      adapter: em_mysqlplus
      encoding: utf8
      pool: 50
      timeout: 5000

    development:
      <<: *defaults
      database: g5kapi_development
      username: root
      password:
      host: 127.0.0.1

    test:
      <<: *defaults
      database: g5kapi_test
      username: root
      password:
      host: 127.0.0.1

    production:
      <<: *defaults
      database: g5kapi_production
      pool: 200
      username: root
      password:
      host: 127.0.0.1

Ruby code to load the configuration:

    # somewhere in an initializer
    h = YAML.load_file(Rails.root.join("config/database.yml").to_s)[Rails.env]

    p Rails.env
    # => "production"

    p h["pool"]
    # => 50

Not exactly the expected result right? In fact it seems that the default YAML parser for Ruby1.9.2 (`Psych`) does not support merge keys (see <http://redmine.ruby-lang.org/issues/show/4300>). Although the fix exists and may be backported soon, the current workaround is to revert to using the `Syck` engine:

    # somewhere in an initializer
    YAML::ENGINE.yamler = "syck"

    h = YAML.load_file(Rails.root.join("config/database.yml").to_s)[Rails.env]

    p Rails.env
    # => "production"

    p h["pool"]
    # => 200
