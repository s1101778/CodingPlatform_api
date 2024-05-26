<?php

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
        Schema::create('assignments', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(CodingClass::class)->nullable()->constrained()->onDelete('cascade')->comment('外鍵_課程ID');
            $table->unsignedTinyInteger('type')->comment('1.影片 2.附件 3.影片+附件 ');
            $table->text('name')->comment('作業名稱');
            $table->text('content')->nullable()->comment('作業內容');
            $table->text('file')->nullable()->comment('檔案位置');
            $table->timestamp('start_at')->nullable()->comment('作業開始時間');
            $table->timestamp('end_at')->nullable()->comment('作業結束時間');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('assignments');
    }
};
