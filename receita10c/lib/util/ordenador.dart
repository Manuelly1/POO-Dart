class Ordenador {
  List ordenar(List objetos, bool Function(dynamic, dynamic, bool) callback, bool crescente) {
    List objetosOrdenados = List.of(objetos);
    bool trocouAoMenosUm;

    do {
      trocouAoMenosUm = false;

      for (int i = 0; i < objetosOrdenados.length - 1; i++) {
        var atual = objetosOrdenados[i];
        var proximo = objetosOrdenados[i + 1];

        if (callback(atual, proximo, crescente)) {
          var aux = objetosOrdenados[i];
          objetosOrdenados[i] = objetosOrdenados[i + 1];
          objetosOrdenados[i + 1] = aux;
          trocouAoMenosUm = true;
        }
      }
    } while (trocouAoMenosUm);

    return objetosOrdenados;
  }

  List segundoOrdenar(List item, Function funcaoCall) {
    List itemOrdenadas = List.of(item);
    bool trocouAoMenosUm;

    final funcao = funcaoCall;

    do {
      trocouAoMenosUm = false;
      for (int i = 0; i < itemOrdenadas.length - 1; i++) {
        var atual = itemOrdenadas[i];
        var proximo = itemOrdenadas[i + 1];

        if (funcao(atual, proximo)) {
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