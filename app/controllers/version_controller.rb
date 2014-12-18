class VersionController < ApplicationController
  VERSION = File.read(Rails.root.join("VERSION").to_s).strip

  def index
    render json: {version: VERSION}
  end
end
