# Reverse Polish Notation Calculator and Converter

_Because when you're bored, there's no going back..._


If you have no idea what's **Reverse Polish Notation**, you can check it out on [wikipedia](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=3&cad=rja&uact=8&ved=0ahUKEwjH45v8x67YAhXJ4IMKHS_4B_cQFggvMAI&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FReverse_Polish_notation&usg=AOvVaw2mN4WrOI1Sk0mYPBG9JB3U).

Demo: https://wisdomsky.github.io/reverse-polish-notation-js-parser/

---

## Compile

If you want to try to compile the source by yourself, be sure to check out [Jison](https://github.com/zaach/jison).


    > npm install jison -g
    > jison grammar/rpn-grammar.jison
    
## Run


From CLI:

    node rpn sample.txt 
    
For Web:

```html
    <script src="rpn.js"></script>
    <script>
            console.log(rpn.parse('1 2 / 3 + 4 5 * -'))
    </script>
```
