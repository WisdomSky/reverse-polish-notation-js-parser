%lex
%%

\s+                    /* ignore */
[0-9-]+("."[0-9]+)?\b  return 'NUMBER'
"*"                    return '*'
"/"                    return '/'
"-"                    return '-'
"+"                    return '+'
"^"                    return '^'
"%"                    return '%'
<<EOF>>                return 'EOF'
.                      return 'INVALID'

/lex

%start expressions

%%

expressions
    : e EOF
        { return $1; }
    ;

e
    : e e '+'
        { $$ = $1 + $2; }
    | e e '-'
        { $$ = $1 - $2; }
    | e e '/'
        { $$ = $1 / $2; }
    | e e '*'
        { $$ = $1 * $2; }
    | e e '%'
        { $$ = $1 % $2; }
    | e e '^'
        { $$ = Math.pow($1, $2); }
    | NUMBER
        { $$  = Number($1);};
