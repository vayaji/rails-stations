# frozen_string_literal: true

module Admin
  class MoviesController < ApplicationController
    def index
      @movies = Movie.all
    end
  end
end
