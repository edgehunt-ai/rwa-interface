import '../models/hip3_live.dart';

abstract interface class Hip3LiveRepository {
  Stream<Hip3LiveUpdate> subscribe(Hip3LiveQuery query);
}
