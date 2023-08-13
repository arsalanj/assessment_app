// To parse this JSON data, do
//
//     final characterModel = characterModelFromJson(jsonString);

import 'dart:convert';

CharacterModel characterModelFromJson(String str) =>
    CharacterModel.fromJson(json.decode(str));

String characterModelToJson(CharacterModel data) => json.encode(data.toJson());

class CharacterModel {
  String characterModelAbstract;
  String abstractSource;
  String abstractText;
  String abstractUrl;
  String answer;
  String answerType;
  String definition;
  String definitionSource;
  String definitionUrl;
  String entity;
  String heading;
  String image;
  int imageHeight;
  int imageIsLogo;
  int imageWidth;
  String infobox;
  String redirect;
  List<RelatedTopic> relatedTopics;
  List<dynamic> results;
  String type;
  Meta meta;

  CharacterModel({
    required this.characterModelAbstract,
    required this.abstractSource,
    required this.abstractText,
    required this.abstractUrl,
    required this.answer,
    required this.answerType,
    required this.definition,
    required this.definitionSource,
    required this.definitionUrl,
    required this.entity,
    required this.heading,
    required this.image,
    required this.imageHeight,
    required this.imageIsLogo,
    required this.imageWidth,
    required this.infobox,
    required this.redirect,
    required this.relatedTopics,
    required this.results,
    required this.type,
    required this.meta,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        characterModelAbstract: json["Abstract"],
        abstractSource: json["AbstractSource"],
        abstractText: json["AbstractText"],
        abstractUrl: json["AbstractURL"],
        answer: json["Answer"],
        answerType: json["AnswerType"],
        definition: json["Definition"],
        definitionSource: json["DefinitionSource"],
        definitionUrl: json["DefinitionURL"],
        entity: json["Entity"],
        heading: json["Heading"],
        image: json["Image"],
        imageHeight: json["ImageHeight"],
        imageIsLogo: json["ImageIsLogo"],
        imageWidth: json["ImageWidth"],
        infobox: json["Infobox"],
        redirect: json["Redirect"],
        relatedTopics: List<RelatedTopic>.from(
            json["RelatedTopics"].map((x) => RelatedTopic.fromJson(x))),
        results: List<dynamic>.from(json["Results"].map((x) => x)),
        type: json["Type"],
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "Abstract": characterModelAbstract,
        "AbstractSource": abstractSource,
        "AbstractText": abstractText,
        "AbstractURL": abstractUrl,
        "Answer": answer,
        "AnswerType": answerType,
        "Definition": definition,
        "DefinitionSource": definitionSource,
        "DefinitionURL": definitionUrl,
        "Entity": entity,
        "Heading": heading,
        "Image": image,
        "ImageHeight": imageHeight,
        "ImageIsLogo": imageIsLogo,
        "ImageWidth": imageWidth,
        "Infobox": infobox,
        "Redirect": redirect,
        "RelatedTopics":
            List<dynamic>.from(relatedTopics.map((x) => x.toJson())),
        "Results": List<dynamic>.from(results.map((x) => x)),
        "Type": type,
        "meta": meta.toJson(),
      };
}

class Meta {
  dynamic attribution;
  dynamic blockgroup;
  dynamic createdDate;
  String description;
  dynamic designer;
  dynamic devDate;
  String devMilestone;
  List<Developer> developer;
  String exampleQuery;
  String id;
  dynamic isStackexchange;
  String jsCallbackName;
  dynamic liveDate;
  Maintainer maintainer;
  String name;
  String perlModule;
  dynamic producer;
  String productionState;
  String repo;
  String signalFrom;
  String srcDomain;
  int srcId;
  String srcName;
  SrcOptions srcOptions;
  dynamic srcUrl;
  String status;
  String tab;
  List<String> topic;
  int unsafe;

  Meta({
    this.attribution,
    this.blockgroup,
    this.createdDate,
    required this.description,
    this.designer,
    this.devDate,
    required this.devMilestone,
    required this.developer,
    required this.exampleQuery,
    required this.id,
    this.isStackexchange,
    required this.jsCallbackName,
    this.liveDate,
    required this.maintainer,
    required this.name,
    required this.perlModule,
    this.producer,
    required this.productionState,
    required this.repo,
    required this.signalFrom,
    required this.srcDomain,
    required this.srcId,
    required this.srcName,
    required this.srcOptions,
    this.srcUrl,
    required this.status,
    required this.tab,
    required this.topic,
    required this.unsafe,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        attribution: json["attribution"],
        blockgroup: json["blockgroup"],
        createdDate: json["created_date"],
        description: json["description"],
        designer: json["designer"],
        devDate: json["dev_date"],
        devMilestone: json["dev_milestone"],
        developer: List<Developer>.from(
            json["developer"].map((x) => Developer.fromJson(x))),
        exampleQuery: json["example_query"],
        id: json["id"],
        isStackexchange: json["is_stackexchange"],
        jsCallbackName: json["js_callback_name"],
        liveDate: json["live_date"],
        maintainer: Maintainer.fromJson(json["maintainer"]),
        name: json["name"],
        perlModule: json["perl_module"],
        producer: json["producer"],
        productionState: json["production_state"],
        repo: json["repo"],
        signalFrom: json["signal_from"],
        srcDomain: json["src_domain"],
        srcId: json["src_id"],
        srcName: json["src_name"],
        srcOptions: SrcOptions.fromJson(json["src_options"]),
        srcUrl: json["src_url"],
        status: json["status"],
        tab: json["tab"],
        topic: List<String>.from(json["topic"].map((x) => x)),
        unsafe: json["unsafe"],
      );

  Map<String, dynamic> toJson() => {
        "attribution": attribution,
        "blockgroup": blockgroup,
        "created_date": createdDate,
        "description": description,
        "designer": designer,
        "dev_date": devDate,
        "dev_milestone": devMilestone,
        "developer": List<dynamic>.from(developer.map((x) => x.toJson())),
        "example_query": exampleQuery,
        "id": id,
        "is_stackexchange": isStackexchange,
        "js_callback_name": jsCallbackName,
        "live_date": liveDate,
        "maintainer": maintainer.toJson(),
        "name": name,
        "perl_module": perlModule,
        "producer": producer,
        "production_state": productionState,
        "repo": repo,
        "signal_from": signalFrom,
        "src_domain": srcDomain,
        "src_id": srcId,
        "src_name": srcName,
        "src_options": srcOptions.toJson(),
        "src_url": srcUrl,
        "status": status,
        "tab": tab,
        "topic": List<dynamic>.from(topic.map((x) => x)),
        "unsafe": unsafe,
      };
}

class Developer {
  String name;
  String type;
  String url;

  Developer({
    required this.name,
    required this.type,
    required this.url,
  });

  factory Developer.fromJson(Map<String, dynamic> json) => Developer(
        name: json["name"],
        type: json["type"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "url": url,
      };
}

class Maintainer {
  String github;

  Maintainer({
    required this.github,
  });

  factory Maintainer.fromJson(Map<String, dynamic> json) => Maintainer(
        github: json["github"],
      );

  Map<String, dynamic> toJson() => {
        "github": github,
      };
}

class SrcOptions {
  String directory;
  int isFanon;
  int isMediawiki;
  int isWikipedia;
  String language;
  String minAbstractLength;
  int skipAbstract;
  int skipAbstractParen;
  String skipEnd;
  int skipIcon;
  int skipImageName;
  String skipQr;
  String sourceSkip;
  String srcInfo;

  SrcOptions({
    required this.directory,
    required this.isFanon,
    required this.isMediawiki,
    required this.isWikipedia,
    required this.language,
    required this.minAbstractLength,
    required this.skipAbstract,
    required this.skipAbstractParen,
    required this.skipEnd,
    required this.skipIcon,
    required this.skipImageName,
    required this.skipQr,
    required this.sourceSkip,
    required this.srcInfo,
  });

  factory SrcOptions.fromJson(Map<String, dynamic> json) => SrcOptions(
        directory: json["directory"],
        isFanon: json["is_fanon"],
        isMediawiki: json["is_mediawiki"],
        isWikipedia: json["is_wikipedia"],
        language: json["language"],
        minAbstractLength: json["min_abstract_length"],
        skipAbstract: json["skip_abstract"],
        skipAbstractParen: json["skip_abstract_paren"],
        skipEnd: json["skip_end"],
        skipIcon: json["skip_icon"],
        skipImageName: json["skip_image_name"],
        skipQr: json["skip_qr"],
        sourceSkip: json["source_skip"],
        srcInfo: json["src_info"],
      );

  Map<String, dynamic> toJson() => {
        "directory": directory,
        "is_fanon": isFanon,
        "is_mediawiki": isMediawiki,
        "is_wikipedia": isWikipedia,
        "language": language,
        "min_abstract_length": minAbstractLength,
        "skip_abstract": skipAbstract,
        "skip_abstract_paren": skipAbstractParen,
        "skip_end": skipEnd,
        "skip_icon": skipIcon,
        "skip_image_name": skipImageName,
        "skip_qr": skipQr,
        "source_skip": sourceSkip,
        "src_info": srcInfo,
      };
}

class RelatedTopic {
  String firstUrl;
  Icon icon;
  String result;
  String text;

  RelatedTopic({
    required this.firstUrl,
    required this.icon,
    required this.result,
    required this.text,
  });

  factory RelatedTopic.fromJson(Map<String, dynamic> json) => RelatedTopic(
        firstUrl: json["FirstURL"],
        icon: Icon.fromJson(json["Icon"]),
        result: json["Result"],
        text: json["Text"],
      );

  Map<String, dynamic> toJson() => {
        "FirstURL": firstUrl,
        "Icon": icon.toJson(),
        "Result": result,
        "Text": text,
      };
}

class Icon {
  String height;
  String url;
  String width;

  Icon({
    required this.height,
    required this.url,
    required this.width,
  });

  factory Icon.fromJson(Map<String, dynamic> json) => Icon(
        height: json["Height"],
        url: json["URL"],
        width: json["Width"],
      );

  Map<String, dynamic> toJson() => {
        "Height": height,
        "URL": url,
        "Width": width,
      };
}
