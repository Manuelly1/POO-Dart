class Filtrador{
  
  List filtrar(List objetos, String filtro, Function callbackDecididor){
    List objetosFiltrados = [];
    for (int i=0; i<objetos.length; i++){
      if (callbackDecididor(objetos[i], filtro) ){
        objetosFiltrados.add(objetos[i]);
      }
    }
    return objetosFiltrados;
  }
}  
