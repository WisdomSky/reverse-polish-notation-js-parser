
%{

var pattern = /^(\(.+[+-\/\*].+\)|([0-9-]+("."[0-9]+)?\b))$/;

function wrapParen(str) {
    if (!pattern.test(str)) {
        return '(' + str + ')';
    }
    return str;
}


var stack = []

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
        { return stack.length ? stack[0] : 'unknown error'; }
    ;

e
    : e e '+'
        {
            stack.push([stack.pop(), stack.pop()].reverse().join(' + '));
        }
    | e e '-'
        {
            stack.push([stack.pop(), stack.pop()].reverse().join(' - '));
        }
    | e e '/'
        {
            stack.push([wrapParen(stack.pop()), wrapParen(stack.pop())].reverse().join(' / '));
        }
    | e e '*'
        {
            stack.push([wrapParen(stack.pop()), wrapParen(stack.pop())].reverse().join(' * '));
        }
    | e e '%'
        {
            stack.push([wrapParen(stack.pop()), wrapParen(stack.pop())].reverse().join(' % '));
        }
    | e e '^'
        {
            stack.push([wrapParen(stack.pop()), wrapParen(stack.pop())].reverse().join(' ^ '));
        }
    | NUMBER
        {
            stack.push(Number($1))
        };
