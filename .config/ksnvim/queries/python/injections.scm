 ; extends

(expression_statement (call function: (attribute attribute: (identifier) @_method (#any-of? @_method "execute" "executemany" "mogrify")) arguments: (argument_list (string (string_content) @injection.content (#set! injection.language "sql")))))

(expression_statement (assignment left: (identifier) @_name (#eq? @_name "sql") right: (string (string_content) @injection.content (#set! injection.language "sql"))))
