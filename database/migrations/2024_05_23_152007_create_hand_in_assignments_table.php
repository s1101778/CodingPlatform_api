<?php
use App\Models\Assignment;
use App\Models\Post;
use App\Models\TempPost;
use App\Models\User;
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
        Schema::create('hand_in_assignments', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(User::class)->constrained()->onDelete('cascade')->comment('外鍵_user_ID');
            $table->foreignIdFor(Assignment::class)->constrained()->onDelete('cascade')->comment('外鍵_作業ID');
            $table->foreignIdFor(TempPost::class)->nullable()->constrained()->onDelete('cascade')->comment('外鍵_temp貼文ID');
            $table->text('file')->nullable()->comment('檔案位置');
            $table->unsignedTinyInteger('status')->default(0)->comment('0: 未批改 1:已批改');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('hand_in_assignments');
    }
};
