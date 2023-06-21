extension NonNullString on String? {
  String get orEmpty {
    if (this == null) {
      return '';
    } else {
      return this!;
    }
  }



  String get orEmptyData {
    if (this == null || this!.isEmpty) {
      return '0000';
    } else {
      return this!;
    }
  }
}

extension NonNullInteger on int? {
  int orZeo() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}
