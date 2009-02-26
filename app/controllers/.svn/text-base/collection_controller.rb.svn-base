require 'Collector'

class CollectionController < ApplicationController
  include Collector

  def startCollection
    Collector.__collect
    render :nothing =>true
  end
  
end
