class ErrorController < ApplicationController
    # This controller is only called when an error occurs. When it does, the notice flashed message is presented to the user.
    def index
        render 'error'
    end
end
