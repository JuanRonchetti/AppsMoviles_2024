class Usuario{
  String name;
  final String _password;
  //int? _year;
  

  Usuario( {required this.name, required String password} ) : _password = password;
  //Usuario(this.name , this._password);

  /// Retorna true si la contrasenia coincide
  bool verifyPassword(String pass) {
    if(pass == _password) 
    {
      return true;
    } 
    else 
    {
      return false;
    }
  }
}

final List<Usuario> listaDeUsuarios = [
  Usuario(name: "Elend", password: "vin123"),
  Usuario(name: "Vin", password: "duralumin321"),
  Usuario(name: "admin", password: "123")
];
