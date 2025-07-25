enum OrderOptions {
  dateModified,
  dateCreated;

  String get name {
    return switch (this) {
      OrderOptions.dateModified => 'Modified Date',
      OrderOptions.dateCreated => ' Created Date',
    };
  }
}
