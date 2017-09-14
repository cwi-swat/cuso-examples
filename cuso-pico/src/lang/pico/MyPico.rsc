module lang::pico::MyPico

extend lang::pico::\syntax::Main;
import util::IDE;
import util::ResourceMarkers;
import Message;

syntax Statement 
  = "for" /* add your own stuff here */
  ;
  
start[Program] parsePico(str input, loc src)
  = parse(#start[Program], input, src);
    
void registerPico() {
  registerLanguage("Pico", "pico", parsePico);
}

public loc fac = |project://cuso-pico/src/lang/pico/fac.pico|;

set[Message] getWarnings(start[Program] prog) 
  = {warning("Alert!", prog.top.decls@\loc)};
  
void registerPicoWithBenefits() {
  registerLanguage("Pico", "pico", parsePico);
  registerContributions("Pico", {
    annotator(Tree (Tree x) { 
      return x[@messages=getWarnings(x)]; 
    })
  });
}  