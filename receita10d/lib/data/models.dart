class Beer{
  String name, style, ibu;
  Beer({this.name='',this.style='',this.ibu=''});

  Beer.fromJson(Map<String, dynamic> json):
    name = json['name'] ?? '',
    style = json['style'] ?? '',
    ibu = json['ibu'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['name'] = this.name;
    data['style'] = this.style;
    data['ibu'] = this.ibu;

    return data;
  }

  void copy(Map<String, dynamic> json){
    name = json['name'] ?? name;
    style = json['style'] ?? style;
    ibu = json['ibu'] ?? ibu;
  }
}


class Coffee{
  String blendName, origin, variety;
  Coffee({this.blendName='', this.origin='', this.variety=''});

  Coffee.fromJson(Map<String, dynamic> json):
    blendName = json['blend_name'] ?? '',
    origin = json['origin'] ?? '',
    variety = json['variety'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['blend_name'] = this.blendName;
    data['origin'] = this.origin;
    data['variety'] = this.variety;

    return data;
  }

  void copy(Map<String, dynamic> json){
    blendName = json['blend_name'] ?? blendName;
    origin = json['origin'] ?? origin;
    variety = json['variety'] ?? variety;
  }
}


class Nation{
  String nationality, capital, language, nationalSport;
  Nation({this.nationality='', this.capital='', this.language='', this.nationalSport=''});

  Nation.fromJson(Map<String, dynamic> json):
    nationality = json['nationality'] ?? '',
    capital = json['capital'] ?? '',
    language = json['language'] ?? '',
    nationalSport = json['national_sport'] ?? '';
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['nationality'] = this.nationality;
    data['capital'] = this.capital;
    data['language'] = this.language;
    data['national_sport'] = this.nationalSport;

    return data;
  }

  void copy(Map<String, dynamic> json){
    nationality = json['nationality'] ?? nationality;
    capital = json['capital'] ?? capital;
    language = json['language'] ?? language;
    nationalSport = json['national_sport'] ?? nationalSport;
  }
}