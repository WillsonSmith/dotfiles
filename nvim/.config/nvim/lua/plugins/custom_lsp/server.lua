local cslsp = {}

function cslsp.server(opts)
  opts = opts or {}
  local capabilities = opts.capabilities or {}
  local on_request = opts.on_request or function(_, _) end
  local on_notify = opts.on_notify or function(_, _) end
  local handlers = opts.handlers or {}

  return function(dispatchers)
    local closing = false
    local srv = {}
    local request_id = 0

    function srv.request(method, params, callback)
      pcall(on_request, method, params)
      local handler = handlers[method]
      if handler then
        local response, err = handler(method, params)
        callback(err, response)
      elseif method == "initialize" then
        callback(nil, {
          capabilities = capabilities,
        })
      elseif method == "shutdown" then
        callback(nil, nil)
      end
      request_id = request_id + 1
      return true, request_id
    end

    function srv.notify(method, params)
      pcall(on_notify, method, params)
      if method == "exit" then
        dispatchers.on_exit(0, 15)
      end
    end

    function srv.is_closing()
      return closing
    end

    function srv.terminate()
      closing = true
    end

    return srv
  end
end

return cslsp
