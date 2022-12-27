class TareasDAO {
  int? idTarea;
  String? decTarea;
  String? fechaEnt;  

  TareasDAO({this.idTarea, this.decTarea, this.fechaEnt});
  factory TareasDAO.fromJSON(Map<String, dynamic> mapTarea){
    return TareasDAO(
      idTarea: mapTarea['idTarea'], 
      decTarea: mapTarea['decTarea'], 
      fechaEnt: mapTarea['fechaEnt']
    );
  }
}