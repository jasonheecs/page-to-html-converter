#!/usr/bin/env ruby

require 'sinatra/base'
require 'erb'
require_relative 'helpers/url-parser'

class WikiConverter < Sinatra::Base
  helpers Sinatra::WikiConverter::Helpers::URLParser

  get '/' do
    erb :index, layout: true
  end

  post '/result' do
    html = get_body(params[:url])
    erb :result, locals: { html: html }, layout: true
  end
end
