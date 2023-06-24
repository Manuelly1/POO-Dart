abstract class Decididor{

  bool precisaTrocarAtualPeloProximo(dynamic atual, dynamic proximo);

}

class Ordenador(List objetos, Decididor decididor) {
    List objetosOrdenados = List.of(objetos);
    bool trocouAoMenosUm;

    do{
      trocouAoMenosUm = false;

      for (int i=0; i<objetosOrdenados.length-1; i++){
        var atual = objetosOrdenados[i];
        var proximo = objetosOrdenados[i+1];

        if ( decididor.precisaTrocarAtualPeloProximo(atual,proximo)) {
          var aux = objetosOrdenados[i];
          objetosOrdenados[i] = objetosOrdenados[i+1];
          objetosOrdenados[i+1] = aux;
          trocouAoMenosUm = true;
        }
      }

    }while(trocouAoMenosUm);

    return objetosOrdenados;

}