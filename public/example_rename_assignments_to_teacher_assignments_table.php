<?php
use App\Models\Assignment;
use Illuminate\Database\Console\Migrations\MigrateCommand;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Models\CodingClass;

return new class extends Migration
{

    public function up()
    {
        Schema::table('assignments', function (Blueprint $table){
            $table->dropForeign(['coding_class_id']);
        });
        Schema::rename('assignments', 'teacher_assignments');

        Schema::table('teacher_assignments', function (Blueprint $table){
            $table->foreign('coding_class_id')->references('id')->on('coding_classes')->onDelete('cascade');
        });
    }


    public function down()
    {
        Schema::table('teacher_assignments', function (Blueprint $table){
            $table->dropForeign(['coding_class_id']);
        });
        Schema::rename('teacher_assignments', 'assignments');
    
        Schema::table('assignments', function (Blueprint $table){
            $table->foreign('coding_class_id')->references('id')->on('coding_class')->onDelete('cascade');
        });
    }
};