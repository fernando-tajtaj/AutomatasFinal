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
    KEYWORD, NUMBER, WHITESPACE, SYMBOL, DATATYPE, CONDITIONAL, LOOP, STRING, EXPRESSION, COMMENT
  }
%}

%%

/* Operadores lógicos */
"and"|"or"|"not" { 
    if (yytext().length() == 2 || yytext().length() == 3) // Verifica que no esté en medio de otra palabra
        return new Yytoken(TokenType.KEYWORD, yytext(), yyline, yycolumn); 
}

/* Otros keywords */
"as"|"assert"|"async"|"await"|"class"|"def"|"del"|"from"|"global"|"import"| 
"lambda"|"nonlocal"|"pass"|"raise"|"with"|"print"|"return" { 
    if (yytext().length() <= 6) // Ajusta según la longitud de las palabras reservadas
        return new Yytoken(TokenType.KEYWORD, yytext(), yyline, yycolumn); 
}

/* Números */
[0-9]+ { return new Yytoken(TokenType.NUMBER, yytext(), yyline, yycolumn); }

/* Espacios en blanco */
[\t\n\r ]+ { return new Yytoken(TokenType.WHITESPACE, yytext(), yyline, yycolumn); }

/* Símbolos y operadores */
. { return new Yytoken(TokenType.SYMBOL, yytext(), yyline, yycolumn); }

/* Tipos de datos */
"False"|"None"|"True" { 
    if (yytext().length() <= 5) // Ajusta según la longitud de las palabras reservadas
        return new Yytoken(TokenType.DATATYPE, yytext(), yyline, yycolumn); 
}

/* Condicionales */
"if"|"else"|"elif"|"try"|"except"|"finally" { 
    if (yytext().length() <= 5) // Ajusta según la longitud de las palabras reservadas
        return new Yytoken(TokenType.CONDITIONAL, yytext(), yyline, yycolumn); 
}

/* Bucles y continuaciones */
"for"|"foreach"|"break"|"continue"|"return"|"yield" { 
    if (yytext().length() <= 6) // Ajusta según la longitud de las palabras reservadas
        return new Yytoken(TokenType.LOOP, yytext(), yyline, yycolumn); 
}

/* Cadenas de texto entre comillas dobles */
\"(\\\"|[^\"])*\" { return new Yytoken(TokenType.STRING, yytext(), yyline, yycolumn); }

/* Expresiones entre llaves */
\{([^{}]|\\.)*\} { return new Yytoken(TokenType.EXPRESSION, yytext(), yyline, yycolumn); }

/* Comentarios de múltiples líneas (docstrings) */
\"\"\"([^\"\\]|\\.)*?\"\"\" { return new Yytoken(TokenType.COMMENT, yytext(), yyline, yycolumn); }

/* Comentarios de una línea (empezando con #, capturando el resto de la línea) */
"#"[^\n]* { return new Yytoken(TokenType.COMMENT, yytext(), yyline, yycolumn); }
