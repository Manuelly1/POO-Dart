import 'decididor.dart';
class Ordenador{
  List ordenarItem(List item, Decididor decididor){
    List itemOrdenadas = List.of(item);
    bool trocouAoMenosUm;

    do{
      trocouAoMenosUm = false;

      for (int i=0; i<itemOrdenadas.length-1; i++){
        var atual = itemOrdenadas[i];
        var proximo = itemOrdenadas[i+1];

        if (decididor.precisaTrocarAtualPeloProximo(atual,proximo)){
          var aux = itemOrdenadas[i];
          itemOrdenadas[i] = itemOrdenadas[i+1];
          itemOrdenadas[i+1] = aux;
          trocouAoMenosUm = true;
        }
      }
    }while(trocouAoMenosUm);
    return itemOrdenadas;
  }
}