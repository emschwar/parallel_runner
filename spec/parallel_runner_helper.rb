# -*- coding: utf-8 -*-
require 'rspec'
require 'mechanize'
require File.dirname(__FILE__) + "/../lib/parallel_runner"

def exec_time
  t = Time.now.to_f
    yield
    Time.now.to_f - t
end

def list
  [
    "http://www.yahoo.co.jp",
    "http://www.google.co.jp",
    "http://twitter.com/",
    "http://www.hatena.ne.jp/"
  ]
end

def map
  {
    :yahoo => "http://www.yahoo.co.jp",
    :google => "http://www.google.co.jp",
    :twitter => "http://twitter.com/",
    :hatena => "http://www.hatena.ne.jp/"
  }
end

def get_agent
  Mechanize.new.tap do |mechanize|
    mechanize.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
end

def time_by_each_parallel
  agent = get_agent
  exec_time {
    list.each_parallel do |url|
      site = agent.get(url)
      html = (site / "//title")[0].inner_html
      html.should_not be_nil
    end
  }
end

def time_by_each
  agent = get_agent
  exec_time {
    list.each do |url|
      site = agent.get(url)
      html = (site / "//title")[0].inner_html
      html.should_not be_nil
    end
  }
end

def time_by_each_with_index
  agent = get_agent
  exec_time {
    list.each_with_index do |url, index|
      site = agent.get(url)
      html = (site / "//title")[0].inner_html
      html.should_not be_nil
    end
  }
end

def time_by_each_by_map
  agent = get_agent
  exec_time {
    map.each do |name, url|
      site = agent.get(url)
      html = (site / "//title")[0].inner_html
      html.should_not be_nil
    end
  }
end
