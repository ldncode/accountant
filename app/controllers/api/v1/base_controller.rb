class Api::V1::BaseController < ApplicationController
  include Response
  include ExceptionHandler
end
