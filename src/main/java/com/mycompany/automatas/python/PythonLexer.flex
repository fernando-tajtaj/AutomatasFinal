package com.mycompany.automatas.python;

%%

%class PythonLexer
%unicode
%line
%column
%{
  public class Yytoken {
    TokenType type;
    String value;
    int line;
    int column;

    public Yytoken(TokenType type, String value, int line, int column) {
      this.type = type;
      this.value = value;
      this.line = line;
      this.column = column;
    }
  }

  enum TokenType {
    KEYWORD, NUMBER, IDENTIFIER, WHITESPACE, SYMBOL, DATATYPE, CONDITIONAL, LOOP
  }
%}

%%

/* Tipos de datos */
"False"|"None"|"True" { return new Yytoken(TokenType.DATATYPE, yytext(), yyline, yycolumn); }

/* Condicionales */
"if"|"else"|"elif"|"while"|"for"|"try"|"except"|"finally" { return new Yytoken(TokenType.CONDITIONAL, yytext(), yyline, yycolumn); }

/* Bucles y continuaciones */
"break"|"continue"|"return"|"yield" { return new Yytoken(TokenType.LOOP, yytext(), yyline, yycolumn); }

/* Operadores logicos */
"and"|"or"|"not" { return new Yytoken(TokenType.KEYWORD, yytext(), yyline, yycolumn); }

/* Otros keywords */
"as"|"assert"|"async"|"await"|"class"|"def"|"del"|"from"|"global"|"import"|
"lambda"|"nonlocal"|"pass"|"raise"|"with" { return new Yytoken(TokenType.KEYWORD, yytext(), yyline, yycolumn); }

/* Números */
[0-9]+ { return new Yytoken(TokenType.NUMBER, yytext(), yyline, yycolumn); }

/* Identificadores */
[a-zA-Z_][a-zA-Z_0-9]* { return new Yytoken(TokenType.IDENTIFIER, yytext(), yyline, yycolumn); }

/* Espacios en blanco */
[\t\n\r ]+ { return new Yytoken(TokenType.WHITESPACE, yytext(), yyline, yycolumn); }

/* Símbolos y operadores */
. { return new Yytoken(TokenType.SYMBOL, yytext(), yyline, yycolumn); }