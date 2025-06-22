class SheetsController < ApplicationController
  def index
    @sheets = Sheet.all
    @rows = @sheets.map(&:row).uniq.sort
    @columns = @sheets.map(&:column).uniq.sort
  end
end