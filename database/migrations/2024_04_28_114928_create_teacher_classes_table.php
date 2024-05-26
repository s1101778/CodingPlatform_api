<?php

use App\Models\User;
use App\Models\CodingClass;
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
        Schema::create('teacher_classes', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(User::class)->nullable()->constrained()->onDelete('cascade')->comment('外鍵_教師 or TA ID');
            $table->unsignedTinyInteger('user_type')->default(1)->comment('1:教師 , 2:TA');
            $table->foreignIdFor(CodingClass::class)->nullable()->constrained()->onDelete('cascade')->comment('外鍵_課程ID');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('teacher_classes');
    }
};
