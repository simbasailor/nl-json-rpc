;;(context 'jsonrpc)

(set 'ERROR '((-32700 "RPC_PARSE_ERROR")
              (-32600 "RPC_INVALID")
              (-32601 "RPC_METHOD_NOT_FOUND")
              (-32603 "RPC_INVALID_PARAMS")
              (-32693 "RPC_INTERNAL_ERROR")))

(define (check-string request)
  (if (list? request)
      (json2text request)
      request))

(define (new-method-result result data error)
  (let ((ret nil))
    (if (= result "Success")
        (begin
          (setq ret '(("result" "Success")))
          (if data
              (push (list "data" data) ret)
              ret))
        (begin
          (setq ret '(("result" "Failure")))
          (if (list? error)
              (push (list "error" error) ret)
              ret)))))

(define (new-response call-result method-result call-error)
  (let ((response '(("type" "Result"))))
    (if (= call-result "Success")
        (begin
          (push '("call" "Success") response)
          (push (list "ret" method-result) response))
        (begin
          (push '("call" "Failure") response)
          (if (list? call-error)
              (push (list "error" call-error) response))
          response))))

(define (new-error errcode msg data)
  (let ((err nil))
    (setq err (list (list "code" errcode)))
    (push (list "msg" msg) err)
    (if data
        (push (list "data" data) err)
        err)))

(define (single-rpc-process request-json-exp)
  (let ((method (lookup "method" request-json-exp))
        (params (lookup "params" request-json-exp)))
    (if (nil? method)
        )))



;;(context MAIN)
