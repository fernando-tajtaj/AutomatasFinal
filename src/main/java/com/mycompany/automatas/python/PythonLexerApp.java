/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.automatas.python;

import static com.mycompany.automatas.python.PythonLexer.TokenType.COMMENT;
import com.mycompany.automatas.python.PythonLexer.Yytoken;
import java.awt.Color;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTextPane;
import javax.swing.SwingUtilities;
import javax.swing.text.BadLocationException;
import javax.swing.text.Style;
import javax.swing.text.StyleConstants;
import javax.swing.text.StyledDocument;

/**
 *
 * @author alumno
 */
public class PythonLexerApp extends JFrame {

    private JTextPane textPane;
    private PythonLexer lexer;

    public PythonLexerApp() {
        try {
            textPane = new JTextPane();
            lexer = new PythonLexer(new FileReader("C:\\Users\\alumno\\Downloads\\AutomatasFinal\\src\\main\\java\\com\\mycompany\\automatas\\python\\Python.txt"));

            try {
                // Lee y aplica colores
                highlightSyntax();
            } catch (IOException ex) {
                Logger.getLogger(PythonLexerApp.class.getName()).log(Level.SEVERE, null, ex);
            }

            // Configura la ventana
            JFrame frame = new JFrame("Python Syntax Highlighter");
            frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            frame.add(new JScrollPane(textPane));
            frame.setSize(800, 600);
            frame.setVisible(true);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(PythonLexerApp.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void highlightSyntax() throws IOException {
        StyledDocument doc = textPane.getStyledDocument();

        // Estilos para los diferentes tipos de tokens
        Style styleKeyword = doc.addStyle("Keyword", null);
        StyleConstants.setForeground(styleKeyword, Color.BLUE);

        Style styleDatatype = doc.addStyle("Datatype", null);
        StyleConstants.setForeground(styleDatatype, new Color(0, 128, 0));

        Style styleConditional = doc.addStyle("Conditional", null);
        StyleConstants.setForeground(styleConditional, new Color(255, 103, 77));

        Style styleLoop = doc.addStyle("Loop", null);
        StyleConstants.setForeground(styleLoop, Color.BLUE);

        Style styleNumber = doc.addStyle("Number", null);
        StyleConstants.setForeground(styleNumber, Color.RED);

        Style styleComment = doc.addStyle("Comment", null);
        StyleConstants.setForeground(styleComment, new Color(128, 128, 128)); // Gris oscuro para comentarios

        // Procesar el archivo con el lexer
        Yytoken token;
        while ((token = lexer.yylex()) != null) {
            Style style = null;

            // Selecciona el estilo basado en el tipo de token
            switch (token.type) {
                case KEYWORD:
                    style = styleKeyword;
                    break;
                case DATATYPE:
                    style = styleDatatype;
                    break;
                case CONDITIONAL:
                    style = styleConditional;
                    break;
                case LOOP:
                    style = styleLoop;
                    break;
                case NUMBER:
                    style = styleNumber;
                    break;
                case COMMENT:
                    style = styleComment;
                    break;
                case STRING:
                    style = styleComment;
                    break;
                default:
                    // Por defecto, no se aplica estilo
                    break;
            }

            // Inserta el texto con el estilo adecuado
            if (style != null) {
                try {
                    doc.insertString(doc.getLength(), token.value, style);
                } catch (BadLocationException e) {
                    e.printStackTrace();
                }
            } else {
                try {
                    doc.insertString(doc.getLength(), token.value, null);
                } catch (BadLocationException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(PythonLexerApp::new);
    }
}
