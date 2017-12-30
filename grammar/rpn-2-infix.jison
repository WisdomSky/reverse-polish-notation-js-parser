
%{

var pattern = /^(\(.+[+-\/\*].+\)|([0-9-]+("."[0-9]+)?\b))$/;

function wrapParen(str) {
    if (!pattern.test(str)) {
        return '(' + str + ')';
    }
    return str;
}


var rpn_stack = []

%}


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
        { return rpn_stack.length ? rpn_stack[0] : 'unknown error'; }
    ;

e
    : e e '+'
        {
            rpn_stack.push([rpn_stack.pop(), rpn_stack.pop()].reverse().join(' + '));
        }
    | e e '-'
        {
            rpn_stack.push([rpn_stack.pop(), rpn_stack.pop()].reverse().join(' - '));
        }
    | e e '/'
        {
            rpn_stack.push([wrapParen(rpn_stack.pop()), wrapParen(rpn_stack.pop())].reverse().join(' / '));
        }
    | e e '*'
        {
            rpn_stack.push([wrapParen(rpn_stack.pop()), wrapParen(rpn_stack.pop())].reverse().join(' * '));
        }
    | e e '%'
        {
            rpn_stack.push([wrapParen(rpn_stack.pop()), wrapParen(rpn_stack.pop())].reverse().join(' % '));
        }
    | e e '^'
        {
            rpn_stack.push([wrapParen(rpn_stack.pop()), wrapParen(rpn_stack.pop())].reverse().join(' ^ '));
        }
    | NUMBER
        {
            rpn_stack.push(Number($1))
        };
