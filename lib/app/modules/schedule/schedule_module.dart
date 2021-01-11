import 'package:flutter_modular/flutter_modular.dart';
import 'package:manipedi_studio/app/modules/schedule/pages/daily_schedules.dart';
import 'package:manipedi_studio/app/modules/schedule/pages/schedule_job_select.dart';
import 'package:manipedi_studio/app/modules/schedule/pages/schedule_register.dart';
import 'schedule_controller.dart';
import 'schedule_page.dart';

class ScheduleModule extends ChildModule {
  @override
  // Lista de injecoes de dependencia do projeto
  List<Bind> get binds => [Bind((i) => ScheduleController())];

  @override
  // Modulos associados a este aplicativo
  List<ModularRouter> get routers => [
        ModularRouter<String>(
          Modular.initialRoute,
          child: (_, args) => SchedulePage(),
          transition: TransitionType.leftToRight,
        ),
        ModularRouter<String>(
          DailySchedules.routeName,
          child: (_, args) => DailySchedules(),
          transition: TransitionType.leftToRight,
        ),
        ModularRouter<String>(
          ScheduleRegister.routeName,
          child: (_, args) => ScheduleRegister(
            schedule: args.data.schedule,
          ),
          transition: TransitionType.rightToLeftWithFade,
        ),
        ModularRouter<String>(
          ScheduleJobSelect.routeName,
          child: (_, args) => ScheduleJobSelect(),
          transition: TransitionType.size,
        ),
      ];
  static const routeName = "/schedule";
}
