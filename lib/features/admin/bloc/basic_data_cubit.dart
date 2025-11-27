import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/repositories/basic_data_repository.dart';

enum BasicDataType {
  nationality,
  roomType,
  unitDescriptionType,
  propertyType,
  region,
  province,
  city,
  service,
  currency
}

abstract class BasicDataState extends Equatable {
  const BasicDataState();

  @override
  List<Object?> get props => [];
}

class BasicDataInitial extends BasicDataState {}

class BasicDataLoading extends BasicDataState {}

class BasicDataLoaded<T> extends BasicDataState {
  final List<T> items;
  final BasicDataType type;

  const BasicDataLoaded(this.items, this.type);

  @override
  List<Object?> get props => [items, type];
}

class BasicDataError extends BasicDataState {
  final String message;

  const BasicDataError(this.message);

  @override
  List<Object?> get props => [message];
}

class BasicDataCubit extends Cubit<BasicDataState> {
  final BasicDataRepository _repository;

  BasicDataCubit(this._repository) : super(BasicDataInitial());

  // Public getter to access repository from UI
  BasicDataRepository get repository => _repository;

  Future<void> loadData(BasicDataType type, {String? parentId}) async {
    emit(BasicDataLoading());
    try {
      dynamic items;
      switch (type) {
        case BasicDataType.nationality:
          items = await _repository.getNationalities();
          break;
        case BasicDataType.roomType:
          items = await _repository.getRoomTypes();
          break;
        case BasicDataType.unitDescriptionType:
          items = await _repository.getUnitDescriptionTypes();
          break;
        case BasicDataType.propertyType:
          items = await _repository.getPropertyTypes();
          break;
        case BasicDataType.region:
          items = await _repository.getRegions();
          break;
        case BasicDataType.province:
          if (parentId != null) {
            items = await _repository.getProvincesByRegion(parentId);
          } else {
            items = await _repository.getProvinces();
          }
          break;
        case BasicDataType.city:
          if (parentId != null) {
            items = await _repository.getCitiesByProvince(parentId);
          } else {
            items = await _repository.getCities();
          }
          break;
        case BasicDataType.service:
          items = await _repository.getServices();
          break;
        case BasicDataType.currency:
          items = await _repository.getCurrencies();
          break;
      }
      emit(BasicDataLoaded(items, type));
    } catch (e) {
      emit(BasicDataError(e.toString()));
    }
  }

  Future<void> addItem(BasicDataType type, Map<String, dynamic> data) async {
    try {
      switch (type) {
        case BasicDataType.nationality:
          await _repository.addNationality(data['name'],
              nameAr: data['nameAr']);
          break;
        case BasicDataType.roomType:
          await _repository.addRoomType(data['name'], nameAr: data['nameAr']);
          break;
        case BasicDataType.unitDescriptionType:
          await _repository.addUnitDescriptionType(data['name'],
              nameAr: data['nameAr']);
          break;
        case BasicDataType.propertyType:
          await _repository.addPropertyType(data['name'],
              nameAr: data['nameAr']);
          break;
        case BasicDataType.region:
          await _repository.addRegion(data['name'], nameAr: data['nameAr']);
          break;
        case BasicDataType.province:
          await _repository.addProvince(data['regionId'], data['name'],
              nameAr: data['nameAr']);
          break;
        case BasicDataType.city:
          await _repository.addCity(data['provinceId'], data['name'],
              nameAr: data['nameAr']);
          break;
        case BasicDataType.service:
          await _repository.addService(data['name'],
              nameAr: data['nameAr'],
              description: data['description'],
              descriptionAr: data['descriptionAr'],
              price: data['price']);
          break;
        case BasicDataType.currency:
          await _repository.addCurrency(data['code'], data['name'],
              nameAr: data['nameAr'],
              symbol: data['symbol'],
              exchangeRate: data['exchangeRate']);
          break;
      }
      // Reload data
      if (type == BasicDataType.province && data.containsKey('regionId')) {
        loadData(type, parentId: data['regionId']);
      } else if (type == BasicDataType.city && data.containsKey('provinceId')) {
        loadData(type, parentId: data['provinceId']);
      } else {
        loadData(type);
      }
    } catch (e) {
      emit(BasicDataError(e.toString()));
    }
  }

  Future<void> updateItem(
      BasicDataType type, String id, Map<String, dynamic> data) async {
    try {
      switch (type) {
        case BasicDataType.nationality:
          await _repository.updateNationality(id, data['name'],
              nameAr: data['nameAr']);
          break;
        case BasicDataType.roomType:
          await _repository.updateRoomType(id, data['name'],
              nameAr: data['nameAr']);
          break;
        case BasicDataType.unitDescriptionType:
          await _repository.updateUnitDescriptionType(id, data['name'],
              nameAr: data['nameAr']);
          break;
        case BasicDataType.propertyType:
          await _repository.updatePropertyType(id, data['name'],
              nameAr: data['nameAr']);
          break;
        case BasicDataType.region:
          await _repository.updateRegion(id, data['name'],
              nameAr: data['nameAr']);
          break;
        case BasicDataType.province:
          await _repository.updateProvince(id, data['name'],
              nameAr: data['nameAr'], regionId: data['regionId']);
          break;
        case BasicDataType.city:
          await _repository.updateCity(id, data['name'],
              nameAr: data['nameAr'], provinceId: data['provinceId']);
          break;
        case BasicDataType.service:
          await _repository.updateService(id, data['name'],
              nameAr: data['nameAr'],
              description: data['description'],
              descriptionAr: data['descriptionAr'],
              price: data['price']);
          break;
        case BasicDataType.currency:
          await _repository.updateCurrency(id, data['code'], data['name'],
              nameAr: data['nameAr'],
              symbol: data['symbol'],
              exchangeRate: data['exchangeRate']);
          break;
      }
      // Reload data
      if (type == BasicDataType.province && data.containsKey('regionId')) {
        loadData(type, parentId: data['regionId']);
      } else if (type == BasicDataType.city && data.containsKey('provinceId')) {
        loadData(type, parentId: data['provinceId']);
      } else {
        loadData(type);
      }
    } catch (e) {
      emit(BasicDataError(e.toString()));
    }
  }

  Future<void> deleteItem(BasicDataType type, String id,
      {String? parentId}) async {
    try {
      switch (type) {
        case BasicDataType.nationality:
          await _repository.deleteNationality(id);
          break;
        case BasicDataType.roomType:
          await _repository.deleteRoomType(id);
          break;
        case BasicDataType.unitDescriptionType:
          await _repository.deleteUnitDescriptionType(id);
          break;
        case BasicDataType.propertyType:
          await _repository.deletePropertyType(id);
          break;
        case BasicDataType.region:
          await _repository.deleteRegion(id);
          break;
        case BasicDataType.province:
          await _repository.deleteProvince(id);
          break;
        case BasicDataType.city:
          await _repository.deleteCity(id);
          break;
        case BasicDataType.service:
          await _repository.deleteService(id);
          break;
        case BasicDataType.currency:
          await _repository.deleteCurrency(id);
          break;
      }
      loadData(type, parentId: parentId);
    } catch (e) {
      emit(BasicDataError(e.toString()));
    }
  }
}
