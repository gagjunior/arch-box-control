class Language {
  final String _sigla;
  get sigla => this._sigla;

  Language(this._sigla);
}

class Portuguese extends Language {
  Portuguese() : super('pt-BR');

  final Map<String, String> keys = {
    "name": "Nome",
    "helloWorld": "Olá mundo",
  };
}
