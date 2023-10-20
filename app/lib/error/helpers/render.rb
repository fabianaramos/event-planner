module Error::Helpers
  class Render
    def self.json(_error, _status, _message)
      {
        error: _error,
        status: _status,
        message: _message
      }.as_json
    end
  end
end
