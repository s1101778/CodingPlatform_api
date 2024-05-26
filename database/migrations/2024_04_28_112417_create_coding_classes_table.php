<?php
use App\Models\Assignment;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('coding_classes', function (Blueprint $table) {
            $table->id();
            $table->unsignedTinyInteger('enable')->default(1)->comment('是否開放選課');
            $table->text('school_year')->comment('學年度');
            $table->text('name')->comment('課程名稱');
            $table->unsignedInteger('student_count')->default(0)->comment('學生數量');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('coding_classes');
    }
};
