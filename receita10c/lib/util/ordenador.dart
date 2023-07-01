import 'decididor.dart';
class Ordenador {
    List ordenarItem(List item, bool Function(dynamic, dynamic, bool) callback, bool crescente) {
      List itemOrdenadas = List.of(item);
      bool trocouAoMenosUm;

      do {
        trocouAoMenosUm = false;

        for (int i = 0; i < itemOrdenadas.length - 1; i++) {
          var atual = itemOrdenadas[i];
          var proximo = itemOrdenadas[i + 1];

          if (callback(atual, proximo, crescente)) {
            var aux = itemOrdenadas[i];
            itemOrdenadas[i] = itemOrdenadas[i + 1];
            itemOrdenadas[i + 1] = aux;
            trocouAoMenosUm = true;
          }
        }
      } while (trocouAoMenosUm);

      return itemOrdenadas;
    }
}
