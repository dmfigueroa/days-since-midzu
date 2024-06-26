class SinceController < ApplicationController
  def show
    @data = Record.first
  end
end
