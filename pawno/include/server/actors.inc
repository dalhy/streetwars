#include <a_samp>

new 
    PizzaioloLS,
    MercadorAP,
    MercadorLS;

stock LoadActors() {
    PizzaioloLS = CreateActor(155, 376.681274, -117.278663, 1001.492187, 183.914230); // Pizzaria LS
    MercadorLS = CreateActor(213, 2351.5095, -648.0492, 128.0547, 188.4411); // Mercador Los Santos
    MercadorAP = CreateActor(179, -264.5023, -2183.7661, 28.9274, 288.1671); // Mercador Angel Pine
    
    SetActorInvulnerable(PizzaioloLS, true);
    SetActorInvulnerable(MercadorLS, true);
    SetActorInvulnerable(MercadorAP, true);
    return 1;
}