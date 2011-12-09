Twelve (gauge)
==================

This is an unofficial ruby client for the [Gauges API](http://get.gaug.es/documentation/api/). The end goal is a complete, simple, and intuitive ruby API for all things Gauges.

Usage
-----

Instantiate the client:

    access_token = "abcd1234"
    bfg = Twelve.new(access_token)

### Your Information

Get your information:

    bfg.me

Update your information:

    bfg.me({
      :first_name => "John",
      :last_name => "Doe"
    })

### API Clients

Get your API clients:

    bfg.clients

Create an API client:

    bfg.clients.create(:description => "12 Gauge")

Delete an API client:

    client_id = 'abcd1234'
    bfg.clients(client_id).destroy

### Gauges

Get your gauges:

    bfg.gauges

Create a gauge:

    bfg.gauges.create({
      :title => 'theprogrammingbutler.com',
      :tz => 'Eastern Time (US & Canada)'
    })

Get a specific gauge:

    gauge_id = 'abcd1234'
    bfg.gauges(gauge_id)

Update a gauge:

    bfg.gauges('abcd1234', {
      :title => 'Go get your guns'
    })

Delete a gauge:

    bfg.gauges('abcd1234').destroy

### Sharing

List who a gauge is shared with:

    bfg.gauges('abcd1234').shares

Share a gauge:

    bfg.gauges('abcd1234').share({:email => 'john@doe.com'})

Un-share a gauge:

    user_id = '4321dcba'
    bfg.gauges('abcd1234').unshare(user_id)

### Content

Get today's top content for a gauge:

    bfg.gauges('abcd1234').content

Get the second page of top content for a gauge:

    bfg.gauges('abcd1234').content(:page => 2)

Get top content for a specific date of a gauge:

    bfg.gauges('abcd1234').content('2011-12-9')

Get the second page for a specific date:

    bfg.gauges('abcd1234').content('2011-12-9', :page => 2)

### Referrers

Get today's referrers for a gauge:

    bfg.gauges('abcd1234').referrers

Get the second page of referrers for a gauge:

    bfg.gauges('abcd1234').referrers(:page => 2)

Get referrers for a specific date of a gauge:

    bfg.gauges('abcd1234').referrers('2011-12-9')

Get the second page for a specific date:

    bfg.gauges('abcd1234').referrers('2011-12-9', :page => 2)

### Trafic

Get this month's traffic for a gauge:

    bfg.gauges('abcd1234').traffic

Get a specific month's traffic:

    bfg.gauges('abcd1234').traffic('2011-10-1')

### Resolutions

Get this month's screen sizes for a gauge:

    bfg.gauges('abcd1234').traffic

Get a specific month's screen sizes:

    bfg.gauges('abcd1234').traffic('2011-10-1')

### Technology

Get browsers and platforms for a gauge:

    bfg.gauges('abcd1234').technology

Get a specific month's technology:

    bfg.gauges('abcd1234').technology('2011-10-1')

### Search Terms

Get today's search terms for a gauge:

    bfg.gauges('abcd1234').terms

Get the second page of search terms for a gauge:

    bfg.gauges('abcd1234').terms(:page => 2)

Get search terms for a specific date of a gauge:

    bfg.gauges('abcd1234').terms('2011-12-9')

Get the second page for a specific date:

    bfg.gauges('abcd1234').terms('2011-12-9', :page => 2)

### Search Engines

Get search engines for a gauge:

    bfg.gauges('abcd1234').engines

Get a specific month's search engines:

    bfg.gauges('abcd1234').engines('2011-10-1')

### Locations

Get this month's locations for a gauge:

    bfg.gauges('abcd1234').locations

Get a specific month's locations:

    bfg.gauges('abcd1234').locations('2011-10-1')

Testing
-------

The test suite uses [VCR](https://github.com/myronmarston/vcr) to cache actual requests to the Gauges API in a directory called responses in the spec directory. In order for VCR to make and cache the actual calls to the Gauges API you will need to provide your Gauges access_token by placing it in a file named .access_token in the spec directory.

To run the tests for content, referrers, traffic, resolutions, technology, search terms, search engines, and locations, you will also need to have an id for a gauge that has been collecting data for at least two days. You place this gauge id in spec/.gauge_id and spec_helper will use it.

This file is ignored by git (see .gitignore) so you can commit any changes you make to the gem without having to worry about your token being released into the wild.

Now run the test suite:

    bundle
    bundle exec rake

CONTRIBUTE
----------

If you'd like to hack on Twelve, start by forking the repo on GitHub:

https://github.com/jonmagic/twelve

The best way to get your changes merged back into core is as follows:

1. Clone down your fork
1. Create a thoughtfully named topic branch to contain your change
1. Hack away
1. Add tests and make sure everything still passes by running `bundle exec rake`
1. If you are adding new functionality, document it in the README
1. Do not change the version number, we will do that on our end
1. If necessary, rebase your commits into logical chunks, without errors
1. Push the branch up to GitHub
1. Send a pull request for your branch